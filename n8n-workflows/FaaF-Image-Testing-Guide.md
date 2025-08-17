# FaaF Image Testing Guide

## Image Directory Structure

```
helix-core/static/images/
├── profiles/          # Profile pictures for different templates
│   ├── executive_woman_default.png
│   ├── young_professional_default.png
│   ├── career_transition_default.png
│   ├── chuck_norris_default.png
│   └── user_uploads/  # For future user-uploaded images
├── logos/            # Company and brand logos
│   ├── client_logos/
│   └── faaf_academy_logos/
└── covers/           # Cover images and backgrounds
    ├── template_backgrounds/
    └── social_media_covers/
```

## Testing with cURL and Image Parameters

### 1. Test with Default Images (no user image)
```bash
curl -X POST http://0.0.0.0:5678/webhook-test/oracle-podcast_v4 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Sarah Johnson", 
    "email": "sarah@executive.com", 
    "profile_text": "She is a senior executive with 15 years of leadership experience", 
    "job_description": "Chief Technology Officer", 
    "prompt_type": "general"
  }'
```
**Expected:** Female Executive template with default executive woman image

### 2. Test with Custom User Image
```bash
curl -X POST http://0.0.0.0:5678/webhook-test/oracle-podcast_v4 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Alex Thompson", 
    "email": "alex@startup.com", 
    "profile_text": "Recent graduate intern at tech startup", 
    "job_description": "Junior Developer", 
    "prompt_type": "general",
    "user_image": "/static/images/profiles/user_uploads/alex_photo.jpg"
  }'
```
**Expected:** Young Professional template with custom image

### 3. Test Career Transition Detection
```bash
curl -X POST http://0.0.0.0:5678/webhook-test/oracle-podcast_v4 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Mike Rodriguez", 
    "email": "mike@transition.com", 
    "profile_text": "Looking for career change from finance to tech", 
    "job_description": "Exploring new opportunities", 
    "prompt_type": "general"
  }'
```
**Expected:** Career Transition template

### 4. Test Chuck Academy Fallback
```bash
curl -X POST http://0.0.0.0:5678/webhook-test/oracle-podcast_v4 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Chuck Norris", 
    "email": "chuck@roundhouse.com", 
    "profile_text": "Legendary martial artist", 
    "job_description": "Ultimate Fighter", 
    "prompt_type": "general"
  }'
```
**Expected:** Original Chuck Academy template

## Template Selection Logic

The enhanced processor uses these detection patterns:

### Female Executive Template
- **Triggers:** female pronouns + senior role keywords
- **Keywords:** she, her, woman, female + ceo, cto, director, executive, vp
- **Image:** `/static/images/profiles/executive_woman_default.png`

### Young Professional Template  
- **Triggers:** junior/entry level keywords
- **Keywords:** intern, junior, entry, graduate, recent, trainee, associate
- **Image:** `/static/images/profiles/young_professional_default.png`

### Career Transition Template
- **Triggers:** transition/change keywords
- **Keywords:** career change, transition, pivot, looking for, seeking, exploring
- **Image:** `/static/images/profiles/career_transition_default.png`

### Chuck Academy (Default)
- **Triggers:** no specific pattern match
- **Image:** `/static/images/profiles/chuck_norris_default.png`

## Adding Test Images

To add placeholder images for testing:

```bash
# Create placeholder images (you can replace with real images later)
cd /home/angel/helix-hub/helix-core/static/images/profiles

# Create simple colored rectangles as placeholders
echo "Add actual images here for testing" > executive_woman_default.png
echo "Add actual images here for testing" > young_professional_default.png  
echo "Add actual images here for testing" > career_transition_default.png
echo "Add actual images here for testing" > chuck_norris_default.png
```

## Future Enhancements

1. **Image Upload API**: Allow users to upload profile pictures
2. **Dynamic Backgrounds**: Change background based on industry/role
3. **Logo Integration**: Add company logos to templates
4. **Social Media Covers**: Generate shareable cover images
5. **PDF Generation**: Convert HTML templates to PDF format

## Usage in n8n Workflow

Replace your Chuck Academy Processor node code with the enhanced version from `enhanced-faaf-processor.js`. The new processor will:

1. Automatically detect user demographics
2. Select appropriate template
3. Include image paths in output
4. Generate personalized content
5. Maintain backwards compatibility

## Testing Checklist

- [ ] Female executive detection works
- [ ] Young professional detection works  
- [ ] Career transition detection works
- [ ] Chuck Academy fallback works
- [ ] Images load in HTML output
- [ ] Custom user images work
- [ ] All templates render properly
- [ ] Error handling works for missing images
