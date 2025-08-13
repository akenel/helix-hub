# 🎙️ Wins & Wrecks Podcast - Quick Setup Guide

## 📸 Adding Images to Your Episode Package

### 1. Episode Artwork (300x300px)
Replace this section in the HTML:
```html
<div class="episode-artwork-placeholder">
    🎙️<br>
    EPISODE ARTWORK<br>
    <small>(300x300px)</small>
</div>
```

With:
```html
<img src="episode-artwork.jpg" alt="Episode Artwork" style="width: 300px; height: 300px; border-radius: 20px;">
```

### 2. Guest Photo (200x200px)
Replace this section:
```html
<div class="guest-photo-placeholder">EK</div>
```

With:
```html
<img src="evangelia-photo.jpg" alt="Dr. Evangelia Kallivretaki">
```

## 🎨 Background Options

### Option 1: Professional Gradient (Current)
- Clean gradient from blue to purple
- Perfect for business/professional content

### Option 2: Medical Theme
Add this to the CSS body section:
```css
background: linear-gradient(135deg, #74b9ff 0%, #0984e3 50%, #6c5ce7 100%);
```

### Option 3: Podcast Studio Theme
```css
background: linear-gradient(135deg, #2d3436 0%, #636e72 50%, #74b9ff 100%);
```

## 🖨️ PDF Generation Tips

### Method 1: Browser Print
1. Open the HTML file in Chrome/Edge
2. Ctrl+P (Print)
3. Select "Save as PDF"
4. Choose "More settings" → Paper size: A4
5. Margins: Custom (0.5 inches all around)

### Method 2: Add Print CSS (Already included)
The page is optimized for A4 printing with proper page breaks

## 📝 Customization Checklist

- [ ] Replace episode artwork image
- [ ] Add guest professional photo
- [ ] Update LinkedIn URL (currently placeholder)
- [ ] Add your contact information
- [ ] Customize color scheme if needed
- [ ] Test PDF generation
- [ ] Review content for accuracy

## 🚀 Quick Wins for Your Podcast

1. **Consistent Branding**: Use the same color scheme across all episodes
2. **Professional Photos**: High-resolution, professional headshots work best
3. **Episode Numbering**: Add episode numbers for better organization
4. **Social Media Ready**: The design works great for social media previews
5. **Mobile Friendly**: Responsive design looks good on all devices

## 💡 Pro Tips

- **Image Optimization**: Keep images under 500KB for faster loading
- **Font Choices**: The current fonts work well for both screen and print
- **Color Accessibility**: Current colors meet accessibility standards
- **Print Quality**: 300 DPI images recommended for print versions

Ready to make your podcast look professional! 🎉
