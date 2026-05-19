import { onCall } from "firebase-functions/v2/https";
import { setGlobalOptions } from "firebase-functions/v2";

setGlobalOptions({ maxInstances: 10 });

export const createPaymentIntent = onCall(async (request) => {
  return {
    message: "Stripe backend endpoint is ready"
  };
});