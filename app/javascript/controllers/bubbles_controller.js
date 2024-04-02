import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bubbles"
export default class extends Controller {
static targets = [ "popularBubbles", "cityBubbles", "popularBubblesContainer", "cityBubblesContainer"]

  connect() {



    // this.animate();
    this.moveBubbles();
  }

  // animate() {
  //   // setInterval(() => {
  //   //   requestAnimationFrame(this.animate.bind(this));
  //   // }, 2000);
  //   //  requestAnimationFrame(this.animate.bind(this));
  //   this.moveBubbles();
  // }


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
    // Get bubble and container dimensions
    const bubbleRect = bubble.getBoundingClientRect();
    const bubbleWidth = bubbleRect.width;
    const bubbleHeight = bubbleRect.height;
    const containerRect = parentElement.getBoundingClientRect();
    const containerWidth = containerRect.width;
    const containerHeight = containerRect.height;

    // Initialize velocity and position
    let velocityX = (Math.random() - 0.5) * 1;
    let velocityY = (Math.random() - 0.5) * 1;
    let x = Math.random() * (containerWidth - bubbleWidth);
    let y = Math.random() * (containerHeight - bubbleHeight);

    // Update bubble position over time
    const moveBubble = () => {
        // Update position based on velocity
        x += velocityX;
        y += velocityY;

        // Check if bubble hits the edges and adjust position and velocity accordingly
        if (x < 0) {
            x = 0;
            velocityX = Math.abs(velocityX); // Reverse velocity if hitting left container edge
        }
        if (x + bubbleWidth >= containerWidth) {
            x = containerWidth - bubbleWidth;
            velocityX = -Math.abs(velocityX); // Reverse velocity if hitting right container edge
        }
        if (y < 0) {
            y = 0;
            velocityY = Math.abs(velocityY); // Reverse velocity if hitting top container edge
        }
        if (y + bubbleHeight >= containerHeight) {
            y = containerHeight - bubbleHeight;
            velocityY = -Math.abs(velocityY); // Reverse velocity if hitting bottom container edge
        }

        // Update bubble position
        bubble.style.transform = `translate(${x}px, ${y}px)`;

        // Continue moving the bubble
        requestAnimationFrame(moveBubble);
    };

    // Start moving the bubble
    moveBubble();
}



}
