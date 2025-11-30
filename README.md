# 📺 Neo IPTV Viewer (Webview APK Ready)

Ce dépôt contient le code source du lecteur IPTV Web optimisé (`index.html`).

Le but principal de ce projet est de contourner les restrictions de sécurité (blocage du "User-Agent" par le serveur IPTV) en encapsulant ce lecteur HTML/JS dans une application native Android (APK) via un outil Webview (comme App Creator 24).

---

## 🚀 Utilisation et Déploiement

### 1. Fichier Principal
* Le lecteur est contenu dans le fichier **`index.html`** à la racine.

### 2. URL de Publication (GitHub Pages)
Pour convertir le lecteur en APK, vous devez utiliser l'URL publique fournie par GitHub Pages (une fois activée).

* **Format de l'URL :** `https://[votre-nom-utilisateur].github.io/[nom-du-dépôt]/`

### 3. Fonctionnement de l'APK
1.  Ouvrez l'application APK générée.
2.  Entrez votre **Adresse M3U corrigée** : `http://.../get.php?username=...&password=...&output=m3u_plus`
3.  Sélectionnez l'option **"Aucun"** pour le Proxy CORS.

Le moteur d'application natif devrait pouvoir établir la connexion et charger la playlist, car il n'est plus identifié comme un navigateur web standard.
