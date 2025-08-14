"use client";

import { getKeycloak } from "@/keycloak/keycloak";
import { useEffect, useState } from "react";

export function AuthButtons() {
  const [isAuth, setIsAuth] = useState(false);
  const [token, setToken] = useState<string | undefined>(undefined);

  useEffect(() => {
    const kc = getKeycloak();
    if (!kc) return;

    setIsAuth(!!kc.authenticated);
    setToken(kc.token ?? undefined);

    const onToken = () => {
      setIsAuth(!!kc.authenticated);
      setToken(kc.token ?? undefined);
    };

    kc.onAuthSuccess = onToken;
    kc.onAuthRefreshSuccess = onToken;
  }, []);

  const login = async () => {
    const kc = getKeycloak();
    if (!kc) return;
    // idpHint makes Keycloak go straight to Google (optional)
    await kc.login({ idpHint: "google", redirectUri: window.location.href });
  };

  const logout = async () => {
    const kc = getKeycloak();
    if (!kc) return;
    await kc.logout({ redirectUri: window.location.origin });
  };

  return (
    <div style={{ display: "flex", gap: 8 }}>
      {!isAuth ? (
        <button onClick={login}>Sign in with Google</button>
      ) : (
        <>
          <button onClick={logout}>Logout</button>
          <small>token: {token?.slice(0, 16)}…</small>
        </>
      )}
    </div>
  );
}
