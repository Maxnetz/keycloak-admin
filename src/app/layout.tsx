import type { Metadata } from 'next';
import './globals.css';
import { AuthProvider } from '@/components/AuthProvider';

export const metadata: Metadata = {
  title: 'Keycloak + Google (Client-only)',
  description: 'Next.js client-only SSO via Keycloak',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        {/* Wrap children in a client provider here */}
        <AuthProvider>{children}</AuthProvider>
      </body>
    </html>
  );
}
