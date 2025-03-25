// Check if the app is online
export const isOnline = (): boolean => {
    return navigator.onLine;
  };
  
  // Event listeners for online/offline status
  export const setupNetworkListeners = (
    onlineCallback: () => void, 
    offlineCallback: () => void
  ): () => void => {
    window.addEventListener('online', onlineCallback);
    window.addEventListener('offline', offlineCallback);
    
    return () => {
      window.removeEventListener('online', onlineCallback);
      window.removeEventListener('offline', offlineCallback);
    };
  };