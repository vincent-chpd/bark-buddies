import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bubbles"
export default class extends Controller {
static targets = [ "popularBubbles", "cityBubbles", "popularBubblesContainer", "cityBubblesContainer"]

  connect() {



    this.animate();
  }

  animate() {
    // setInterval(() => {
    //   requestAnimationFrame(this.animate.bind(this));
    // }, 2000);
    //  requestAnimationFrame(this.animate.bind(this));
    this.moveBubbles();
  }


  moveBubbles() {
    const popularBubbles = this.popularBubblesTargets;
    const cityBubbles = this.cityBubblesTargets;
    const popularContainerRect = this.popularBubblesContainerTarget
    const cityContainerRect = this.cityBubblesContainerTarget

    popularBubbles.forEach((bubble) => {
      this.moveBubbleRandomly(bubble, popularContainerRect);
    });

    cityBubbles.forEach((bubble) => {
      this.moveBubbleRandomly(bubble, cityContainerRect);
    });
  }

  moveBubbleRandomly(bubble, parentElement) {
    const bubbleRect = bubble.getBoundingClientRect();
    const bubbleWidth = bubbleRect.width;
    const bubbleHeight = bubbleRect.height;


    const bubbleTop = bubbleRect.top;
    const bubbleLeft = bubbleRect.left;
    const bubbleBottom = bubbleTop + bubbleHeight;
    const bubbleRight = bubbleLeft + bubbleWidth;

    console.log(bubbleTop, parentElement.getBoundingClientRect().top)


    const dirX = this.getDirection(bubbleTop, bubbleLeft, bubbleBottom, bubbleRight, parentElement)[0];
    const dirY = this.getDirection(bubbleTop, bubbleLeft, bubbleBottom, bubbleRight, parentElement)[1];
    //console.log(bubbleTop, bubbleLeft, bubbleBottom, bubbleRight)

    // const bubbleCenterX = bubbleX + bubbleRect.width / 2;
    // const bubbleCenterY = bubbleY + bubbleRect.height / 2;

    // const containerCenterX = bubbleContainerRect.width / 2;
    // const containerCenterY = bubbleContainerRect.height / 2;

    // const dx = containerCenterX - bubbleCenterX;
    // const dy = containerCenterY - bubbleCenterY;

    // Adjusting velocity with a random factor
    // const randomFactorX = (Math.random() * 2 - 1) * 50; // Random value between -5 and 5
    // const randomFactorY = (Math.random() * 2 - 1) * 50; // Random value between -5 and 5

    // const newX = bubbleX + dx + randomFactorX;
    // const newY = bubbleY + dy + randomFactorY;

    // Ensure the new position is within the bounds of the container
    // const maxX = bubbleContainerRect.width - bubbleRect.width;
    // const maxY = bubbleContainerRect.height - bubbleRect.height;



    bubble.style.transform = `translate(${dirX}px, ${dirY}px)`;
}

  // changeDirection() {
  //   this.randomFactorX = (Math.random() * 2 - 1) * 50;
  //   this.randomFactorY = (Math.random() * 2 - 1) * 50;
  // }

  getDirection(top, left, bottom, right, parentElement) {
    const bubbleContainerRect = parentElement.getBoundingClientRect();
    const containerWidth = bubbleContainerRect.width;
    const containerHeight = bubbleContainerRect.height;
    const containerTop = bubbleContainerRect.top;
    const containerLeft = bubbleContainerRect.left;
    const containerBottom = containerTop + containerHeight;
    const containerRight = containerLeft + containerWidth;

    let dirX = 0;
    let dirY = 0;

    if (top <= containerTop || bottom <= containerBottom) {
      dirY = 1;
    }else if (bottom >= containerBottom || top >= containerTop) {
      dirY = -1;
    }

    if (left <= containerLeft || right <= containerRight) {
      dirX = 1;
    } else if (right >= containerRight || left >= containerLeft) {
      dirX = -1;
    }

    return [dirX, dirY];
  }

}
