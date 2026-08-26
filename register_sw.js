// app/register_sw.js
const hostname = window.location.hostname;
const isLocal = hostname === "localhost" || hostname === "127.0.0.1";
if (isLocal) {
  console.info("Service Worker: Desactivado en entorno local.");
} else if ("serviceWorker" in navigator) {
  // Registro del Service Worker
  navigator.serviceWorker.register("./sw.js").then((reg) => {
    // Si ya hay un SW activo pero no tenemos la versión (usuario nuevo o caché limpia)
    if (reg.active && !localStorage.getItem("appVersion")) {
      // Forzamos el envío de la versión desde el SW
      reg.active.postMessage({ action: "requestVersion" });
    }
  });

  // Recarga automática cuando el nuevo SW toma el control
  let refreshing = false;
  navigator.serviceWorker.addEventListener("controllerchange", () => {
    if (!refreshing) {
      refreshing = true;
      window.location.reload();
    }
  });
}
