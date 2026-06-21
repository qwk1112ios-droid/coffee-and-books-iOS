import { onCall, HttpsError } from "firebase-functions/v2/https";
import { setGlobalOptions } from "firebase-functions/v2";
import { defineSecret } from "firebase-functions/params";
import Stripe from "stripe";

setGlobalOptions({ maxInstances: 10 });

const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY");

export const createPaymentIntent = onCall(
  { secrets: [stripeSecretKey] },
  async (request) => {
    try {
      const stripe = new Stripe(stripeSecretKey.value());

      const amount = request.data?.amount ?? 1099;
      const currency = request.data?.currency ?? "usd";

      const paymentIntent = await stripe.paymentIntents.create({
        amount,
        currency,
        payment_method_types: ["card"],
      });

      return {
        paymentIntent: paymentIntent.client_secret,
        publishableKey: "pk_test_51TSKmwD0agb75Rps96S0YkxBHVyTTfzdU3GEa4Hi4I1rNkjsKW9Brk2w9HGzLsMAb0vtBfUVsVazBs8hpolDOviJ00ERayXfMg",
      };
    } catch (error) {
      console.error(error);

      throw new HttpsError(
        "internal",
        "Unable to create payment intent"
      );
    }
  }
);