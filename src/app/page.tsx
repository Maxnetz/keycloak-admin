'use client';

import { useAuth } from '@/components/AuthProvider';

export default function Page() {
  const { authenticated, profile, loginWithGoogle, logout, token } = useAuth();

  if (!authenticated) {
    return (
      <main style={{ padding: 24 }}>
        <h1>Welcome</h1>
        <button onClick={loginWithGoogle}>Continue with Google</button>
      </main>
    );
  }

  return (
    <main style={{ padding: 24 }}>
      <h1>Hello {profile?.firstName ?? 'there'} 👋</h1>
      <p>Email: {profile?.email}</p>
      <details>
        <summary>View Access Token (JWT)</summary>
        <pre style={{ whiteSpace: 'pre-wrap', wordBreak: 'break-all' }}>
          {token}
        </pre>
      </details>
      <button onClick={logout}>Logout</button>
    </main>
  );
}
