module.exports = {
  purge: [
    "./pages/**/*.{js,ts,jsx,tsx,elm}",
    "./components/**/*.{js,ts,jsx,tsx}",
    "./src/*.elm",
  ],
  darkMode: "media", // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
