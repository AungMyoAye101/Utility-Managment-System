# Tenent Web App — Utility Management System

A React + TypeScript single-page application (SPA) built with Vite for managing tenant utility workflows. It includes authentication, billing views, customer service requests, contract details, and profile management, with a modern UI built on Tailwind CSS and Radix UI.


## Features (current)
- Authentication
  - Login form with react-hook-form + zod validation
  - Auth state managed via Redux Toolkit (user + accessToken)
  - Axios API client with bearer token injection and refresh-token handling (request/response interceptors)
- Application Shell & Routing
  - React Router with nested routes and index routes
  - Layout with navbar/footer and route children
  - Toast notifications via sonner
- Pages
  - Overview dashboard
  - Customer Service
    - New Request
    - Service History
  - My Billing
    - Latest Bill
    - Billing History
  - Contract Details
  - Profile
- UI & Components
  - Tailwind CSS 4, component primitives via Radix UI
  - Reusable UI components (button, dialog, dropdown, form, input, table, tabs, etc.)
  - Charts (recharts) and table utilities (TanStack Table)
- Data & State
  - Data fetching/caching with TanStack Query
  - Global state via Redux Toolkit, logging with redux-logger
- Developer Experience
  - Vite dev server + TypeScript
  - ESLint configuration
  - Path alias @ → src/


## Tech Stack
- Framework & Build
  - React 19, TypeScript, Vite 7
- Styling & UI
  - Tailwind CSS 4 (+ @tailwindcss/vite plugin)
  - Radix UI components, lucide-react icons
  - class-variance-authority, clsx, tailwind-merge
- Routing & State
  - React Router 7
  - Redux Toolkit, react-redux, redux-logger, redux-persist (installed)
  - TanStack Query (react-query)
- Forms & Validation
  - react-hook-form, zod, @hookform/resolvers
- Data & Visualization
  - axios, recharts, date-fns
- Tooling
  - ESLint 9, typescript-eslint, @vitejs/plugin-react


## Requirements
- Node.js >= 18
- npm >= 9 (package-lock.json present; project is set up for npm)
- Modern browser (Vite dev server defaults to http://localhost:5173)

Optional environment variables (create a .env file at the project root):
- API_BASE_URL: Base URL for the backend API
  - Defaults to http://localhost:3000/api/v1/
  - Example: `API_BASE_URL="https://utility-management-system-32o3.onrender.com"`

Note: Vite only exposes environment variables to the client if they are prefixed with VITE_. This project reads `import.meta.env.API_BASE_URL` directly in the axios client. Ensure your environment supports this or update the client code to read `import.meta.env.VITE_API_BASE_URL` if you prefer the conventional Vite approach.


## Scripts
From package.json:
- dev: Start the Vite dev server
  - `npm run dev`
- build: Type-check and build for production
  - `npm run build` (runs `tsc -b && vite build`)
- preview: Preview the production build locally
  - `npm run preview`
- lint: Lint the codebase
  - `npm run lint`


## Getting Started
1) Install dependencies
   - `npm install`
2) Configure environment (optional)
   - Create a `.env` file and set `API_BASE_URL` if your API is not on the default
3) Run the development server
   - `npm run dev`
4) Build for production
   - `npm run build`
5) Preview the production build
   - `npm run preview`


## Project Structure
```
.
├─ public/
│  ├─ login-illu.svg
│  ├─ logo-final.svg
│  ├─ logo.svg
│  └─ profile.png
├─ src/
│  ├─ assets/
│  │  ├─ logo.svg
│  │  └─ profile.png
│  ├─ components/
│  │  ├─ common/
│  │  │  └─ bread-crumb.tsx
│  │  └─ ui/
│  │     ├─ alert-dialog.tsx
│  │     ├─ aspect-ratio.tsx
│  │     ├─ avatar.tsx
│  │     ├─ breadcrumb.tsx
│  │     ├─ button.tsx
│  │     ├─ card.tsx
│  │     ├─ chart.tsx
│  │     ├─ dialog.tsx
│  │     ├─ dropdown-menu.tsx
│  │     ├─ form.tsx
│  │     ├─ input.tsx
│  │     ├─ label.tsx
│  │     ├─ pagination.tsx
│  │     ├─ select.tsx
│  │     ├─ sonner.tsx
│  │     ├─ table.tsx
│  │     ├─ tabs.tsx
│  │     └─ textarea.tsx
│  ├─ hooks/
│  │  └─ auth/
│  │     ├─ useLogin.ts
│  │     └─ useLogout.ts
│  ├─ layouts/
│  │  ├─ footer.tsx
│  │  ├─ main-page.tsx
│  │  └─ navbar.tsx
│  ├─ lib/
│  │  ├─ pages.ts
│  │  ├─ utils.ts
│  │  └─ validation.ts
│  ├─ pages/
│  │  ├─ auth/
│  │  │  └─ login.tsx
│  │  ├─ contract-details/
│  │  │  └─ contract-details.tsx
│  │  ├─ customer-service/
│  │  │  ├─ customer-service.tsx
│  │  │  ├─ new-request/
│  │  │  │  └─ new-request.tsx
│  │  │  └─ service-history/
│  │  │     └─ service-history.tsx
│  │  ├─ my-billing/
│  │  │  ├─ my-billing.tsx
│  │  │  ├─ latest-bill/
│  │  │  │  └─ latest-bill.tsx
│  │  │  └─ billing-history/
│  │  │     └─ billing-history.tsx
│  │  ├─ overView/
│  │  │  └─ over-view.tsx
│  │  └─ profile/
│  │     └─ profile.tsx
│  ├─ service/
│  │  ├─ apiClient.ts
│  │  ├─ auth-service.ts
│  │  └─ customer-service.ts
│  ├─ store/
│  │  ├─ features/
│  │  │  └─ auth/
│  │  │     └─ authSlice.ts
│  │  └─ store.ts
│  ├─ types/
│  │  └─ auth.ts
│  ├─ App.css
│  ├─ App.tsx
│  ├─ index.css
│  └─ main.tsx
├─ tsconfig.json
├─ vite.config.ts
├─ package.json
├─ package-lock.json
└─ README.md
```

Notes
- API client lives in `src/service/apiClient.ts` and reads `API_BASE_URL`. It injects `Authorization: Bearer <token>` when available and retries upon 401 with a refresh-token flow.
- Redux store is in `src/store/store.ts` with an `auth` slice in `src/store/features/auth/authSlice.ts`.
- Routing is configured in `src/App.tsx` using `createBrowserRouter` with nested routes.
- Path alias `@` points to `src/` (configured in `vite.config.ts` and `tsconfig.json`).


## License
This project is licensed under the ISC License.
