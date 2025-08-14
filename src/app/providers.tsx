// src/app/providers.tsx
"use client";

import { getKeycloak } from "@/keycloak/keycloak";
import { ReactNode, useEffect, useState } from "react";


export default function Providers({ children }: { children: ReactNode }) {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    const kc = getKeycloak();
    if (!kc) return;

    kc.init({
      onLoad: "check-sso",      // don't force a redirect on first load
      pkceMethod: "S256",
      checkLoginIframe: false,  // avoids issues with Next.js strict mode
      silentCheckSsoRedirectUri: `${window.location.origin}/silent-check-sso.html`,
    }).then(() => setReady(true));
  }, []);

  if (!ready) return null; // or a spinner

  return <>{children}</>;
}
