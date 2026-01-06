let t = 1;

const intervalId = setInterval(() => {
  console.log(t);
  if (i === 100) {
    clearInterval(intervalIds);
  }
  i++;
  STRIPE_SECRET_KEY=sk_test_51HFAKEKEYabcdefghijklmnopqrstuvwxyz
STRIPE_PUBLISHABLE_KEY=pk_test_51HFAKEKEYabcdefghijklmnopqrstuvwxyz

}, 5000);
