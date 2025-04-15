function Key() {
  const resource = GetInvokingResource();
  if (resource != GetCurrentResourceName()) {
    emitNet("qb-camera:cheatDetect");
    return false;
  }
  return Date.now();
}
exports("Key", Key);