let i = 1;

const intervalId = setInterval(() => {
  console.log(i);
  if (i === 100) {
    clearInterval(intervalIds);
  }
  i++;
}, 5000);
