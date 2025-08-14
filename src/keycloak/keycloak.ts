'use client';

import Keycloak, { KeycloakInitOptions, KeycloakInstance } from 'keycloak-js';

let kc: KeycloakInstance | null = null;

export function getKeycloak() {
  if (!kc) {
    kc = new Keycloak({
      url: process.env.NEXT_PUBLIC_KEYCLOAK_URL!,
      realm: process.env.NEXT_PUBLIC_KEYCLOAK_REALM!,
      clientId: process.env.NEXT_PUBLIC_KEYCLOAK_CLIENT_ID!,
    });
  }
  return kc!;
}

export async function initKeycloak() {
  const keycloak = getKeycloak();
  const initOptions: KeycloakInitOptions = {
    pkceMethod: 'S256',
    checkLoginIframe: false,       // avoid iframe issues in Next.js
    onLoad: 'check-sso',           // don’t force login on first paint
    silentCheckSsoRedirectUri:     // optional silent SSO (same-origin)
      typeof window !== 'undefined'
        ? `${window.location.origin}/silent-check-sso.html`
        : undefined,
  };
  const authenticated = await keycloak.init(initOptions);
  return { keycloak, authenticated };
}
