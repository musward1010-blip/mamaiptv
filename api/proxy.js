// proxy.js
export default async function handler(req, res) {
  const url = req.query.url;
  if (!url) {
    return res.status(400).json({ error: "Missing url" });
  }

  try {
    const response = await fetch(url, {
      headers: {
        "User-Agent": "Mozilla/5.0", // User-Agent pour éviter le blocage
        "Accept": "*/*"
      }
    });

    // ********* AJOUT CRITIQUE *********
    if (!response.ok) {
        return res.status(502).json({ 
            error: "Upstream fetch failed",
            details: `Source server returned status: ${response.status}`,
            url_tried: url
        });
    }
    // **********************************

    const contentType =
      response.headers.get("content-type") || "application/octet-stream";

    const buffer = Buffer.from(await response.arrayBuffer());

    // Headers CORS pour la sécurité web
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
    res.setHeader("Content-Type", contentType);

    res.status(200).send(buffer);
  } catch (error) {
    console.error("Proxy error:", error);
    res.status(500).json({
      error: "Proxy failed internally",
      details: error.toString(),
    });
  }
}
