"use client";

import { getKeycloak, initKeycloak } from "@/keycloak/keycloak";
import { createContext, useContext, useEffect, useMemo, useState } from "react";

type AuthContextType = {
  authenticated: boolean;
  token?: string;
  loginWithGoogle: () => void;
  logout: () => void;
  profile?: Keycloak.KeycloakProfile;
};

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [authenticated, setAuthenticated] = useState(false);
  const [token, setToken] = useState<string | undefined>();
  const [profile, setProfile] = useState<
    Keycloak.KeycloakProfile | undefined
  >();

  useEffect(() => {
    let refreshTimer: number | undefined;

    (async () => {
      const { keycloak, authenticated } = await initKeycloak();
      setAuthenticated(!!authenticated);
      if (authenticated) {
        setToken(keycloak.token);
        try {
          const p = await keycloak.loadUserProfile();
          setProfile(p);
        } catch {}
      }

      // token refresh loop
      const tick = async () => {
        try {
          const refreshed = await keycloak.updateToken(30); // refresh if <30s
          if (refreshed) setToken(keycloak.token);
        } catch (e) {
          console.warn("Token refresh failed", e);
        }
      };
      refreshTimer = window.setInterval(tick, 20_000);
    })();

    return () => {
      if (refreshTimer) window.clearInterval(refreshTimer);
    };
  }, []);

  const actions = useMemo(() => {
    const kc = getKeycloak();
    return {
      loginWithGoogle: () =>
        kc.login({
          idpHint: "google", // <<— jump straight to Google
          redirectUri: process.env.NEXT_PUBLIC_APP_URL, // or window.location.href
        }),
      logout: () => kc.logout({ redirectUri: process.env.NEXT_PUBLIC_APP_URL }),
    };
  }, []);

  const value: AuthContextType = { authenticated, token, profile, ...actions };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be used within <AuthProvider>");
  return ctx;
}
