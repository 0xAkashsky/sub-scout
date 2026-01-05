let t = 1;

const intervalId = setInterval(() => {
  console.log(t);
  if (i === 100) {
    clearInterval(intervalIds);
  }
  i++;
}, 5000);
