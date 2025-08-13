# 🎙️ Podcast Episode Generator Script
# Parses structured content and generates professional HTML packages

param(
    [string]$ContentFile,
    [string]$ProfileImage,
    [string]$EpisodeArtwork,
    [string]$OutputPath = ".",
    [switch]$Preview
)

# Script configuration
$ScriptVersion = "1.0"

function Write-Banner {
    param([string]$Message, [string]$Color = "Cyan")
    
    Write-Host ""
    Write-Host "====================================== " -ForegroundColor $Color
    Write-Host "   $Message" -ForegroundColor $Color
    Write-Host "====================================== " -ForegroundColor $Color
    Write-Host ""
}

function Convert-ImageToBase64 {
    param([string]$ImagePath)
    
    try {
        if (-not (Test-Path $ImagePath)) {
            throw "Image file not found: $ImagePath"
        }
        
        # Validate file type
        $extension = [IO.Path]::GetExtension($ImagePath).ToLower()
        $allowedTypes = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp")
        
        if ($extension -notin $allowedTypes) {
            throw "Unsupported image type: $extension. Allowed types: $($allowedTypes -join ', ')"
        }
        
        $imageBytes = [IO.File]::ReadAllBytes($ImagePath)
        
        # Check file size (warn if over 2MB)
        if ($imageBytes.Length -gt 2MB) {
            Write-Host "WARNING: Large image file ($([math]::Round($imageBytes.Length / 1MB, 1))MB). Consider resizing for better performance." -ForegroundColor Yellow
        }
        
        $base64 = [Convert]::ToBase64String($imageBytes)
        
        # Determine image type
        $mimeType = switch ($extension) {
            ".jpg"  { "image/jpeg" }
            ".jpeg" { "image/jpeg" }
            ".png"  { "image/png" }
            ".gif"  { "image/gif" }
            ".bmp"  { "image/bmp" }
            ".webp" { "image/webp" }
            default { "image/jpeg" }
        }
        
        $dataUri = "data:$mimeType;base64,$base64"
        
        Write-Host "SUCCESS: Image converted: $([math]::Round($imageBytes.Length / 1KB, 1))KB to $([math]::Round($base64.Length / 1KB, 1))KB" -ForegroundColor Green
        
        return $dataUri
    }
    catch {
        Write-Host "ERROR converting image: $_" -ForegroundColor Red
        return $null
    }
}

function Parse-StructuredContent {
    param([string]$Content)
    
    $data = @{}
    
    # Extract sections using regex patterns
    $data.GuestBio = if ($Content -match '\*\*1\. Short Guest Bio\*\*\s*\n(.*?)(?=\n\*\*2\.|$)') { $matches[1].Trim() } else { "" }
    $data.WinStories = if ($Content -match '\*\*2\. ""Win"" Story Prompts\*\*\s*\n(.*?)(?=\n\*\*3\.|$)') { $matches[1].Trim() } else { "" }
    $data.WreckStories = if ($Content -match '\*\*3\. ""Wreck"" Story Prompts\*\*\s*\n(.*?)(?=\n\*\*4\.|$)') { $matches[1].Trim() } else { "" }
    $data.InterviewQuestions = if ($Content -match '\*\*4\. Deep-Dive Interview Questions\*\*\s*\n(.*?)(?=\n\*\*5\.|$)') { $matches[1].Trim() } else { "" }
    $data.Frameworks = if ($Content -match '\*\*5\. Tool/Framework Tips to Discuss\*\*\s*\n(.*?)(?=\n\*\*Potential Episode Hook\*\*|$)') { $matches[1].Trim() } else { "" }
    $data.EpisodeHook = if ($Content -match '\*\*Potential Episode Hook:\*\*\s*\n""(.*?)""') { $matches[1].Trim() } else { "" }
    
    return $data
}

function Format-ContentSection {
    param([string]$Content, [string]$Type = "list")
    
    if ([string]::IsNullOrWhiteSpace($Content)) { return "<p>Content to be discussed during interview.</p>" }
    
    switch ($Type) {
        "list" {
            $lines = $Content -split '\n' | Where-Object { $_.Trim() -ne "" }
            $html = "<ul>"
            foreach ($line in $lines) {
                $cleanLine = $line -replace '^\*\s*', '' -replace '^\d+\.\s*', ''
                if ($cleanLine.Trim() -ne "") {
                    $html += "<li>$($cleanLine.Trim())</li>"
                }
            }
            $html += "</ul>"
            return $html
        }
        "numbered" {
            $lines = $Content -split '\n' | Where-Object { $_.Trim() -ne "" }
            $html = "<ol>"
            foreach ($line in $lines) {
                $cleanLine = $line -replace '^\d+\.\s*', ''
                if ($cleanLine.Trim() -ne "") {
                    $html += "<li>$($cleanLine.Trim())</li>"
                }
            }
            $html += "</ol>"
            return $html
        }
        default {
            return "<p>$($Content -replace '\n', '<br>')</p>"
        }
    }
}

# Main execution
Write-Banner "PODCAST EPISODE GENERATOR v$ScriptVersion"

# Interactive mode if no parameters provided
if (-not $ContentFile) {
    Write-Host "Let's create your episode package step by step!" -ForegroundColor Yellow
    Write-Host ""
    
    # Get guest information
    $guestName = Read-Host "Guest full name (e.g., Dr. Evangelia Kallivretaki)"
    $guestFirstName = ($guestName -split ' ')[-1] -replace '\.$', ''
    $guestTitle = Read-Host "Guest title/role (e.g., Medical Affairs Leader)"
    $linkedinUrl = Read-Host "LinkedIn profile URL"
    
    Write-Host ""
    Write-Host "Now paste your structured content below:" -ForegroundColor Yellow
    Write-Host "(Include the bio, win stories, wreck stories, etc. - then press Enter twice)" -ForegroundColor Gray
    
    $ContentText = ""
    $emptyLines = 0
    do {
        $line = Read-Host
        if ([string]::IsNullOrWhiteSpace($line)) {
            $emptyLines++
        } else {
            $emptyLines = 0
            $ContentText += $line + "`n"
        }
    } while ($emptyLines -lt 2)
} else {
    $ContentText = Get-Content $ContentFile -Raw
    $guestName = Read-Host "Guest full name"
    $guestFirstName = ($guestName -split ' ')[-1] -replace '\.$', ''
    $guestTitle = Read-Host "Guest title/role"
    $linkedinUrl = Read-Host "LinkedIn profile URL"
}

# Parse the content
Write-Host ""
Write-Host "Parsing content..." -ForegroundColor Yellow
$parsedContent = Parse-StructuredContent -Content $ContentText

# Auto-generate episode title
$episodeTitle = "From Science to Strategy: $guestFirstName's Journey Through Pharma's Biggest Wins & Wrecks"

# Handle images
Write-Host ""
Write-Host "Image Setup:" -ForegroundColor Yellow
if (-not $ProfileImage) {
    $ProfileImage = Read-Host "Profile image path (drag and drop file here, or press Enter to skip)"
    $ProfileImage = $ProfileImage -replace '"', '' # Remove quotes from drag and drop
}

if (-not $EpisodeArtwork) {
    $EpisodeArtwork = Read-Host "Episode artwork path (drag and drop file here, or press Enter to use default)"
    $EpisodeArtwork = $EpisodeArtwork -replace '"', '' # Remove quotes from drag and drop
}

Write-Host ""
Write-Host "Processing images..." -ForegroundColor Yellow

# Convert images to base64
$profileImageHtml = if ($ProfileImage -and (Test-Path $ProfileImage)) {
    $base64 = Convert-ImageToBase64 -ImagePath $ProfileImage
    if ($base64) { "<img src='$base64' alt='$guestName'>" } else { "<div style='width: 200px; height: 200px; border-radius: 50%; background: #667eea; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: 2em; font-weight: bold;'>$(($guestName -split ' ' | ForEach-Object { $_[0] }) -join '')</div>" }
} else {
    "<div style='width: 200px; height: 200px; border-radius: 50%; background: #667eea; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: 2em; font-weight: bold;'>$(($guestName -split ' ' | ForEach-Object { $_[0] }) -join '')</div>"
}

$episodeArtworkHtml = if ($EpisodeArtwork -and (Test-Path $EpisodeArtwork)) {
    $base64 = Convert-ImageToBase64 -ImagePath $EpisodeArtwork
    if ($base64) { "<img src='$base64' alt='Episode Artwork'>" } else { "<div style='width: 300px; height: 300px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 20px; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: 1.5em; font-weight: bold; text-align: center;'>WINS &<br>WRECKS<br><small>Episode Artwork</small></div>" }
} else {
    "<div style='width: 300px; height: 300px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 20px; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: 1.5em; font-weight: bold; text-align: center;'>WINS &<br>WRECKS<br><small>Episode Artwork</small></div>"
}

# Get the HTML template from the existing file
$templatePath = "d:\docker-projects\helix-mvp\podcast-episode-package.html"
if (Test-Path $templatePath) {
    $html = Get-Content $templatePath -Raw
} else {
    Write-Host "ERROR: Template file not found. Using basic template." -ForegroundColor Red
    $html = @"
<!DOCTYPE html>
<html><head><title>Wins & Wrecks Episode</title></head>
<body>
<h1>{{GUEST_NAME}}</h1>
<p>{{GUEST_BIO}}</p>
</body></html>
"@
}

# Generate HTML
Write-Host "Generating HTML..." -ForegroundColor Yellow

# Replace placeholders
$html = $html -replace 'Dr\. Evangelia Kallivretaki', $guestName
$html = $html -replace 'Medical Affairs Leader • Biopharmaceuticals Expert', $guestTitle
$html = $html -replace 'From Lab to Launch: A Medical Affairs Leader''s Journey Through Pharma''s Biggest Wins & Wrecks', $episodeTitle
$html = $html -replace 'https://linkedin\.com/in/evangeliakallivretaki', $linkedinUrl

# Replace image placeholders
$html = $html -replace '<div class="guest-photo-placeholder">EK</div>', $profileImageHtml
$html = $html -replace '<div class="episode-artwork-placeholder">.*?</div>', $episodeArtworkHtml

# Replace content sections if found in template
if ($parsedContent.GuestBio) {
    $bioPattern = 'Dr\. Evangelia Kallivretaki is a seasoned Medical Affairs leader.*?impact\.'
    $html = $html -replace $bioPattern, $parsedContent.GuestBio
}

# Save output
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputFileName = "$($guestFirstName.ToLower())-episode-$timestamp.html"
$outputFilePath = Join-Path $OutputPath $outputFileName

$html | Out-File -FilePath $outputFilePath -Encoding UTF8

Write-Banner "EPISODE PACKAGE GENERATED SUCCESSFULLY!" "Green"
Write-Host "Output file: $outputFilePath" -ForegroundColor Green
Write-Host "File size: $([math]::Round((Get-Item $outputFilePath).Length / 1KB, 1))KB" -ForegroundColor Green
Write-Host ""
Write-Host "Preview in browser:" -ForegroundColor Cyan
Write-Host "Start-Process '$outputFilePath'" -ForegroundColor Gray
Write-Host ""
Write-Host "Generate PDF:" -ForegroundColor Cyan
Write-Host "Open in browser -> Ctrl+P -> Save as PDF" -ForegroundColor Gray

if ($Preview) {
    Start-Process $outputFilePath
}

Write-Host ""
Write-Host "Ready for your next episode? Run the script again!" -ForegroundColor Magenta
