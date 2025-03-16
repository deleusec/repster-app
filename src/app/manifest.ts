import type { MetadataRoute } from 'next'
 
export default function manifest(): MetadataRoute.Manifest {
  return {
    name: 'Repster',
    short_name: 'Respster',
    description: 'Repster is your ultimate workout companion',
    start_url: '/',
    display: 'standalone',
    background_color: 'oklch(14.62% 0.0064 285.58)',
    theme_color: 'oklch(14.62% 0.0064 285.58)',
    icons: [
      {
        src: '/icon-192x192.png',
        sizes: '192x192',
        type: 'image/png',
      },
      {
        src: '/icon-512x512.png',
        sizes: '512x512',
        type: 'image/png',
      },
    ],
  }
}