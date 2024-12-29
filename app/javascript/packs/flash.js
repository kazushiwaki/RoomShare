export function handleFlashMessages() {
  const flashMessages = document.getElementById("flash-messages");
  if (flashMessages) {
    // スライドインアニメーション
    flashMessages.style.position = "fixed";
    flashMessages.style.top = "-100px"; // 初期位置（画面外上部）
    flashMessages.style.left = "50%";
    flashMessages.style.transform = "translateX(-50%)";
    flashMessages.style.transition = "top 0.5s ease-out";
    flashMessages.style.zIndex = "50";

    // アニメーション開始
    setTimeout(() => {
      flashMessages.style.top = "10px"; // 表示位置
    }, 100);

    // スライドアウトアニメーション
    setTimeout(() => {
      flashMessages.style.transition = "top 0.5s ease-in, opacity 0.5s ease-in";
      flashMessages.style.top = "-100px"; // 再び画面外上部へ
      flashMessages.style.opacity = "0";

      // アニメーション終了後に要素を削除
      setTimeout(() => {
        flashMessages.remove();
      }, 500);
    }, 5000); // 表示時間：5秒
  }
}
