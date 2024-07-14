export default {
  name: "video-onebox",
  initialize() {
    document.addEventListener("DOMContentLoaded", function() {
      const script1 = document.createElement('link');
      script1.href = "https://vjs.zencdn.net/8.10.0/video-js.css";
      script1.rel = "stylesheet";
      document.head.appendChild(script1);

      const script2 = document.createElement('script');
      script2.src = "https://vjs.zencdn.net/8.10.0/video.min.js";
      script2.onload = function() {
        const domList = document.querySelectorAll('.video-js');
        domList.forEach((videoElement) => {
          const player = videojs(videoElement);
          player.ready(function() {
            console.log("Player is ready!");
          });
        });
      };
      document.body.appendChild(script2);
    });
  }
};
