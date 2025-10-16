# ⚛️ `vite-tailwind-setup.sh` 🚀

## ⚡️ **Vite, React, and Tailwind CSS v4 Quickstart Script**

Tired of the repetitive boilerplate setup for a new web project? This single-file Bash script automates the creation of a modern, themed, and production-ready **React** application using **Vite** and the latest **Tailwind CSS v4** alpha.

It handles installation, configuration, file cleanup, and the creation of essential components and includes a **functional dark mode toggle** right out of the box.

-----

## ✨ Features

This script transforms a default `npm create vite` project into a fully styled application in seconds:

  * **Vite + React Setup:** Initializes a standard React project using `npm create vite@latest`.
  * **Tailwind CSS v4 Alpha:** Installs `tailwindcss@^4.0.0-alpha.1` and configures the new **CSS-first** methodology.
  * **Zero-Config Tailwind:** Automatically sets up `vite.config.js` with the necessary Vite and Tailwind plugins.
  * **Theming with Oklch:** Implements custom design tokens directly in `src/index.css` using the modern `oklch` color space and the new `@theme` directive.
  * **Custom Utilities:** Defines reusable utility classes like `.card-container`, `.btn-primary`, and `.input-field` using the new `@utility` syntax.
  * **Instant Dark Mode:** Sets up root-level dark mode styling and includes a component with a **working dark mode toggle**.
  * **Default Components:** Creates boilerplate `Header`, `Card`, and `Footer` components to showcase the theming and utilities.
  * **Code Cleanup:** Removes all default Vite boilerplate (logos, unused CSS) for a **clean slate**.

-----

## 🛠️ Usage

### 1\. Save the Script

Copy the script code (from your local file) and save it as **`vite-tailwind-setup.sh`** in your desired directory.

### 2\. Make it Executable

Open your terminal, navigate to the folder where you saved the script, and run the following command to grant it execution permission:

```bash
chmod +x ./vite-tailwind-setup.sh
```

### 3\. Run the Script

Execute the setup script:

```bash
./vite-tailwind-setup.sh
```

The script will promptly ask you to enter the **name of your new project folder**.

### 4\. Start Developing\!

Once the script completes, you'll see a success message. Navigate into your new project folder and start the development server:

```bash
cd YOUR_PROJECT_NAME
npm run dev
```

Your new React application will be running, fully themed with Tailwind CSS v4, and ready for you to build upon\!

-----

## 🎨 Default Theming

The script establishes a modern color palette and typography using the new Tailwind CSS v4 `@theme` directive, which you can easily customize in `src/index.css`.

| Token Name | Example Value | Description |
| :--- | :--- | :--- |
| `--font-sans` | `Inter, sans-serif` | Highly readable font optimized for UI. |
| `--color-primary` | `oklch(75% 0.1 245)` | A modern, distinct blue color. |
| `--color-secondary` | `oklch(70% 0.1 295)` | A supporting violet color. |
| `--color-accent` | `oklch(70% 0.1 345)` | A bright pink for accents. |

### Included Custom Utilities

| Utility | Definition | Purpose |
| :--- | :--- | :--- |
| `.card-container` | `bg-white/30 backdrop-blur-lg` | Creates a frosted, glass-like UI element with dark mode support. |
| `.btn-primary` | `bg-primary text-white` | Applies primary theme colors and button styles. |
| `.input-field` | `bg-gray-200/50 border-2 focus:border-primary` | A clean, interactive input field with a focus effect. |
