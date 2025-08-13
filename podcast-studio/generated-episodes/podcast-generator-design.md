# 🎙️ Podcast Episode Generator - Requirements & Design

## 📋 Script Requirements Analysis

### Input Requirements:
1. **Guest Information** (JSON/Text file)
   - Name, title, bio
   - LinkedIn URL, email
   - Episode topics (wins/wrecks)
   - Interview questions

2. **Images** (Optional paths)
   - Profile image (required)
   - Episode artwork (optional - generates default if missing)
   - Background images for pages (optional)

3. **Template** (HTML template file)
   - Base template with placeholders
   - CSS styling preferences
   - Branding elements

### Output:
- Self-contained HTML file with embedded images
- PDF-ready formatting
- Professional episode package

## 🛠️ Script Design Options

### Option A: PowerShell Script (Windows-friendly)
```powershell
# .\Generate-PodcastEpisode.ps1 -GuestData "guest-data.json" -ProfileImage "photo.jpg"
```

**Pros:**
- Native Windows integration
- Easy image processing
- JSON handling built-in
- File system operations

**Cons:**
- Windows-only
- Limited image manipulation

### Option B: Python Script (Cross-platform)
```python
# python generate_episode.py --guest-data guest.json --profile-image photo.jpg
```

**Pros:**
- Cross-platform
- Rich image processing (Pillow)
- JSON/templating libraries
- Better error handling

**Cons:**
- Requires Python installation
- Dependency management

### Option C: Node.js Script (Web-friendly)
```javascript
// node generate-episode.js --config guest-config.json
```

**Pros:**
- Great templating engines
- HTML/CSS processing
- Package ecosystem
- Familiar syntax

**Cons:**
- Requires Node.js
- JavaScript quirks

## 🎯 Recommended Approach: PowerShell + Python Hybrid

### Why This Combo?
- **PowerShell**: File operations, user interaction, Windows integration
- **Python**: Image processing, template generation, complex logic

## 📁 Suggested File Structure

```
podcast-generator/
├── generate-episode.ps1           # Main PowerShell script
├── templates/
│   ├── base-template.html         # Your current template
│   ├── minimal-template.html      # Simpler version
│   └── corporate-template.html    # Professional version
├── scripts/
│   ├── image-processor.py         # Python image handling
│   └── template-engine.py         # HTML generation
├── config/
│   ├── default-settings.json     # Default configurations
│   └── guest-template.json       # Guest data template
├── output/                        # Generated episodes
└── assets/
    ├── default-artwork.png        # Fallback images
    └── podcast-logo.png
```

## 🔧 Script Features

### User Interaction Flow:
1. **Welcome & Setup**
   ```
   🎙️ Podcast Episode Generator v1.0
   Choose template: [1] Professional [2] Minimal [3] Corporate
   ```

2. **Guest Information**
   ```
   Guest name: Dr. Evangelia Kallivretaki
   Episode title: [Auto-generate] or [Custom]
   ```

3. **Image Processing**
   ```
   Profile image path: C:\Users\angel\Pictures\profile.jpg
   ✅ Image found (2.1MB) - Optimizing...
   ✅ Converted to Base64 (450KB)
   
   Episode artwork: [Use default] or [Custom path]
   ```

4. **Content Input**
   ```
   Bio: [Paste text] or [Load from file]
   Win stories: [Interactive input]
   Wreck stories: [Interactive input]
   ```

5. **Generation**
   ```
   ✅ Template processed
   ✅ Images embedded
   ✅ HTML generated: output/evangelia-episode.html
   ✅ Preview available: file:///.../evangelia-episode.html
   ```

### Error Handling:
- Image file validation
- Size optimization warnings
- Template syntax checking
- Output file collision handling

### Quality Features:
- **Image Optimization**: Auto-resize large images
- **Template Validation**: Check for required placeholders
- **Preview Mode**: Generate without committing
- **Backup**: Save previous versions

## 🚀 Quick Start vs Full Features

### MVP Version (This Week):
- Basic PowerShell script
- Your current template
- Simple image embedding
- Manual guest data input

### Full Version (Later):
- GUI interface
- Multiple templates
- Batch processing
- Cloud integration

## 💡 What I Recommend:

1. **Start with PowerShell MVP** - Get it working for your 3 friends
2. **Add Python image processing** - Better quality & optimization
3. **Create guest data templates** - Standardize input format
4. **Build template library** - Different styles for different guests

## 🎯 Questions for You:

1. **Template Variety**: Do you want different visual themes for different industries?
2. **Guest Data**: JSON file input or interactive prompts?
3. **Image Requirements**: Auto-crop to square, or manual preparation?
4. **Output Format**: Just HTML, or also generate PDF automatically?
5. **Branding**: Same podcast branding, or customizable per episode?

**Should I build the MVP PowerShell script first, or do you want to refine the requirements?**
