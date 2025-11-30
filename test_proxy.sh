#!/bin/bash

DOMAIN="https://mama-iptv-web.vercel.app"
TEST_URL="https://example.com"
IPTV_TEST="http://cf.business-cdn-neo.me/live/8388dbf7f0cf/29f51e7d19/270800.ts"

echo "🔍 Test 1 : Vérification route API"
curl -I "$DOMAIN/api/proxy?url=$TEST_URL" 2>/dev/null | head -n 1

echo
echo "🔍 Test 2 : Vérification en-têtes"
curl -I "$DOMAIN/api/proxy?url=$TEST_URL" 2>/dev/null | grep -i "content-type"

echo
echo "🔍 Test 3 : Test flux IPTV (.ts)"
curl -I "$DOMAIN/api/proxy?url=$IPTV_TEST" 2>/dev/null | head -n 1

echo
echo "🔍 Test 4 : Téléchargement fragment IPTV"
curl "$DOMAIN/api/proxy?url=$IPTV_TEST" --output test_fragment.ts --max-time 5 2>/dev/null

if [ -f "test_fragment.ts" ]; then
  SIZE=$(du -h test_fragment.ts | cut -f1)
  echo "📦 Fragment téléchargé : $SIZE"
else
  echo "❌ Aucun fragment téléchargé"
fi

echo
echo "📌 Diagnostic final :"

HTTP1=$(curl -I "$DOMAIN/api/proxy?url=$TEST_URL" 2>/dev/null | head -n 1 | grep -c "200")
HTTP2=$(curl -I "$DOMAIN/api/proxy?url=$IPTV_TEST" 2>/dev/null | head -n 1 | grep -c "200")

if [ "$HTTP1" -eq 1 ] && [ "$HTTP2" -eq 1 ]; then
  echo "✅ PROXY FONCTIONNE ✔✔"
else
  echo "❌ PROXY NE FONCTIONNE PAS ❗"
fi

