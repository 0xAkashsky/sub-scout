let i = 1;

const intervalId = setInterval(() => {
  console.log(i);
  if (i === 100) {
    clearInterval(intervalId);
  }
  i++;
}, 5000);
