#!/bin/bash

# --- 1. PROMPT FOR PROJECT NAME ---
echo "What's the name of your new project?"
read -p "Project Name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "Project name cannot be empty. Exiting."
  exit 1
fi

echo "Creating project in directory: ./$PROJECT_NAME"

# --- 2. CREATE VITE & REACT PROJECT ---
npm create vite@latest "$PROJECT_NAME" -- --template react

# Navigate into the new project directory
cd "$PROJECT_NAME"

# --- 3. INSTALL TAILWIND 4 & REMOVE FLUFF ---
echo "Installing Tailwind CSS v4 and dependencies..."
npm install -D tailwindcss@^4.0.0-alpha.1 @tailwindcss/vite

# Remove Vite's default CSS and App.jsx/App.css
rm src/App.css src/assets/react.svg
sed -i '' '/^import ".\/App.css";/d' src/App.jsx
sed -i '' '/^import reactLogo from/d' src/App.jsx
sed -i '' '/^import viteLogo from/d' src/App.jsx
sed -i '' '/<a href="https:\/\/vitejs.dev"/,/<\/h1>/d' src/App.jsx
sed -i '' '/^  const \[count/d' src/App.jsx
sed -i '' '/<div class="card">/d' src/App.jsx
sed -i '' '/<p class="read-the-docs">/d' src/App.jsx
sed -i '' 's/^\(.*\)\(return (\).*/\2/' src/App.jsx

# --- 4. CONFIGURE VITE FOR TAILWIND 4 ---
cat > vite.config.js <<EOL
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
});
EOL

# --- 5. CORRECT main.jsx FILE ---
# This is the corrected section to fix the ReferenceError
cat > src/main.jsx <<EOL
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App.jsx';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
EOL

# --- 6. CONFIGURE TAILWIND IN CSS (CORRECTED) ---
# Add Tailwind directives, theme, and base styles to index.css
cat > src/index.css <<EOL
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');
@import "tailwindcss";

/* CSS-first configuration using @theme directive */
@theme {
  --font-sans: Inter, sans-serif;
  --color-primary: oklch(75% 0.1 245);  /* A modern blue */
  --color-secondary: oklch(70% 0.1 295); /* A modern violet */
  --color-accent: oklch(70% 0.1 345);   /* A modern pink */

  --color-gray: (
    100: oklch(98% 0 0),
    200: oklch(90% 0 0),
    800: oklch(20% 0 0),
    900: oklch(10% 0 0),
  );
}

@layer base {
  body {
    @apply font-sans bg-gray-100 text-gray-800 transition-colors duration-500;
  }
  .dark body {
    @apply bg-gray-900 text-gray-200;
  }
}

/* Correctly defining custom classes with @utility */
@utility card-container {
    @apply bg-white/30 backdrop-blur-lg p-6 rounded-3xl shadow-lg transition-colors duration-500;
}
.dark .card-container {
    @apply bg-gray-800/30;
}

@utility btn {
    @apply py-2 px-4 font-semibold rounded-full shadow-md transition-all duration-300 transform hover:scale-105;
}

.btn-primary {
  @apply btn bg-primary text-white;
}

.btn-secondary {
  @apply btn bg-secondary text-white;
}

@utility input-field {
    @apply w-full p-3 rounded-lg bg-gray-200/50 border-2 border-transparent focus:border-primary transition-colors duration-300;
}
.dark .input-field {
    @apply bg-gray-700/50;
}

/* Custom variants for dark mode, as per v4 docs */
@custom-variant dark (&:where(.dark, .dark *));
EOL

# --- 7. CREATE THE DEFAULT APP PAGE & COMPONENTS ---
mkdir -p src/components

cat > src/components/Header.jsx <<EOL
import React from 'react';

const Header = () => {
  return (
    <header className="py-6 px-4 sm:px-6 lg:px-8 card-container mb-8">
      <div className="flex justify-between items-center max-w-7xl mx-auto">
        <div className="text-xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
          YourBrand
        </div>
        <nav className="hidden md:flex space-x-4">
          <a href="#" className="hover:text-primary transition-colors">Home</a>
          <a href="#" className="hover:text-primary transition-colors">About</a>
          <a href="#" className="hover:text-primary transition-colors">Contact</a>
        </nav>
        <button className="btn-primary">Get Started</button>
      </div>
    </header>
  );
};

export default Header;
EOL

cat > src/components/Card.jsx <<EOL
import React from 'react';

const Card = ({ title, description, children }) => {
  return (
    <div className="card-container">
      <h3 className="text-2xl font-bold mb-2">{title}</h3>
      <p className="text-gray-600 dark:text-gray-400 mb-4">{description}</p>
      {children}
    </div>
  );
};

export default Card;
EOL

cat > src/components/Footer.jsx <<EOL
import React from 'react';

const Footer = () => {
  return (
    <footer className="mt-auto py-6 px-4 sm:px-6 lg:px-8 text-center text-gray-500 dark:text-gray-400">
      <p>© 2025 YourBrand. All rights reserved.</p>
    </footer>
  );
};

export default Footer;
EOL

# --- 8. CREATE THE DEFAULT APP PAGE ---
cat > src/App.jsx <<EOL
import React, { useState } from 'react';
import Header from './components/Header';
import Card from './components/Card';
import Footer from './components/Footer';

function App() {
  const [isDarkMode, setIsDarkMode] = useState(false);

  const toggleTheme = () => {
    setIsDarkMode(!isDarkMode);
    document.documentElement.classList.toggle('dark', !isDarkMode);
  };

  return (
    <div className={\`flex flex-col min-h-screen \${isDarkMode ? 'dark' : ''}\`}>
      <Header />
      <main className="flex-grow p-4 md:p-8 max-w-7xl mx-auto w-full">
        <div className="text-center mb-12">
          <h1 className="text-5xl md:text-6xl font-extrabold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent mb-4">
            Hello, Vite + React!
          </h1>
          <p className="text-lg md:text-xl text-gray-600 dark:text-gray-400">
            A modern starter template for your next web project.
          </p>
        </div>
        <div className="grid md:grid-cols-2 gap-8 lg:grid-cols-3">
          <Card
            title="Card One"
            description="This is a beautiful frosted card using Tailwind's backdrop-filter and custom classes."
          >
            <button className="btn-primary">Learn More</button>
          </Card>
          <Card
            title="Dark Mode"
            description="Toggle the dark mode to see the theme change in real-time."
          >
            <button
              onClick={toggleTheme}
              className="btn-secondary"
            >
              Toggle Dark Mode
            </button>
          </Card>
          <Card
            title="Form Example"
            description="A simple form to demonstrate a basic input field."
          >
            <form>
              <input
                type="text"
                placeholder="Enter your name"
                className="input-field mb-4"
              />
              <button type="submit" className="btn-primary w-full">
                Submit
              </button>
            </form>
          </Card>
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default App;
EOL

echo "Project setup complete! To start your development server, run:"
echo "cd $PROJECT_NAME && npm run dev"