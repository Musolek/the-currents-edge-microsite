# The Current's Edge - Book Microsite

A beautiful, responsive microsite for your YA Neo-African Futuristic novel, built with React + Vite and styled to match the aesthetic of [Paste.app](https://pasteapp.io/).

## Features

- **Responsive Design**: Looks great on desktop, tablet, and mobile
- **Smooth Animations**: Powered by Framer Motion with scroll-triggered effects
- **Modern UI**: Clean, minimalist design with Tailwind CSS
- **Interactive Elements**: 
  - Mailing list signup (saves to localStorage)
  - Excerpt modal
  - Smooth scrolling navigation
  - Parallax effects
- **SEO Ready**: Proper meta tags and semantic HTML

## Quick Start

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Start development server**:
   ```bash
   npm run dev
   ```

3. **Build for production**:
   ```bash
   npm run build
   ```

## Customization

### Book Information
Edit the `BOOK` object in `src/BookMicrosite.jsx`:

```javascript
const BOOK = {
  title: "Your Book Title",
  subtitle: "Your book's tagline or description",
  cover: "path/to/your/cover.jpg", // Add your cover image
  buyLink: "https://your-buy-link.com", // Your purchase/preorder link
  excerpt: "Your book excerpt...",
  author: {
    name: 'Your Name',
    bio: "Your author bio",
    photo: "path/to/your/photo.jpg", // Add your author photo
  },
};
```

### Styling
- The site uses Tailwind CSS for styling
- Colors are defined using Tailwind's color palette
- Main brand colors: emerald (green) and sky (blue)
- Customize colors in the component or extend Tailwind config

### Content Sections
The site includes these sections:
- **Hero**: Title, subtitle, and call-to-action buttons
- **About**: Story description and key themes
- **Excerpt**: Book excerpt with modal for full text
- **Reviews**: Early praise and testimonials
- **Buy/Signup**: Purchase links and mailing list
- **Author**: Author bio and photo
- **Footer**: Copyright and links

### Adding Images
1. Place your cover image in the `public` folder
2. Update the `cover` property in the `BOOK` object
3. Do the same for your author photo

### Mailing List
Currently saves to localStorage for demo purposes. To connect to a real service:
1. Replace the `handleMailSubmit` function
2. Integrate with your preferred email service (Mailchimp, ConvertKit, etc.)

### Deployment
The site can be deployed to any static hosting service:
- **Vercel**: `npm run build` then deploy the `dist` folder
- **Netlify**: Connect your GitHub repo or drag & drop the `dist` folder
- **GitHub Pages**: Use the `gh-pages` package

## Tech Stack

- **React 18**: Modern React with hooks
- **Vite**: Fast build tool and dev server
- **Tailwind CSS**: Utility-first CSS framework
- **Framer Motion**: Animation library
- **Lucide React**: Beautiful icons

## Browser Support

- Modern browsers (Chrome, Firefox, Safari, Edge)
- Mobile browsers (iOS Safari, Chrome Mobile)
- No Internet Explorer support

## License

This project is open source and available under the MIT License.