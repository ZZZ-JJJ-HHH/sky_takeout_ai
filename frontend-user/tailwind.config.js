/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: '#ff6b35',
        secondary: '#f7931e',
        success: '#07c160',
        warning: '#ff976a',
        danger: '#ee0a24',
        info: '#1989fa'
      }
    },
  },
  plugins: [],
}