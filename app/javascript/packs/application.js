// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import { handleFlashMessages } from "./flash"

// rails-ujsを起動する
Rails.start()
Turbolinks.start()
ActiveStorage.start()

console.log("javascript 正常作動");


// ユーザーの詳細画面のタブ切り替え
document.addEventListener("turbolinks:load", function () {
  const tabButtons = document.querySelectorAll(".tab-button");
  const tabContents = document.querySelectorAll(".tab-content");

  tabButtons.forEach((button) => {
    button.addEventListener("click", function () {
      const targetTabId = button.getAttribute("data-tab");

      // 全てのタブコンテンツを隠す
      tabContents.forEach((content) => {
        content.classList.add("hidden");
      });

      // 表示するタブコンテンツを特定
      const targetTab = document.getElementById(targetTabId);
      if (targetTab) {
        targetTab.classList.remove("hidden");
      }

      // 全てのタブボタンのスタイルをリセット
      tabButtons.forEach((btn) => {
        btn.classList.remove("text-blue-500", "border-blue-500");
        btn.classList.add("text-gray-600", "border-transparent");
      });

      // クリックされたタブボタンにアクティブ状態を適用
      button.classList.add("text-blue-500", "border-blue-500");
      button.classList.remove("text-gray-600", "border-transparent");
    });
  });
});


document.addEventListener("turbolinks:load", () => {
  handleFlashMessages();
});



// 削除モーダル
document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("delete-modal");
  const cancelButton = document.getElementById("cancel-button");
  const confirmDeleteLink = document.getElementById("confirm-delete-link");
  let deleteUrl = "";

  // 削除リンククリックイベント
  document.body.addEventListener("click", (event) => {
    if (event.target.classList.contains("delete-link")) {
      event.preventDefault();
      deleteUrl = event.target.dataset.url; // data-urlからURL取得
      modal.classList.remove("hidden"); // モーダルを表示
      console.log("Delete URL:", deleteUrl);
    }
  });

  // キャンセルボタンでモーダルを閉じる
  cancelButton.addEventListener("click", () => {
    modal.classList.add("hidden");
    deleteUrl = ""; // URLをクリア
  });

  // 確定ボタンで削除リクエストを送信
  confirmDeleteLink.addEventListener("click", () => {
    if (deleteUrl) {
      console.log("Sending DELETE request to:", deleteUrl);
      fetch(deleteUrl, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Accept": "application/json"
        }
      })
        .then(response => {
          if (response.ok) {
            return response.json(); // レスポンスをJSONとして解析
          } else {
            throw new Error("削除に失敗しました。");
          }
        })
        .then(() => {
          window.location.reload(); // ページをリロード
        })
        .catch(error => {
          alert(error.message || "エラーが発生しました。");
        });

      modal.classList.add("hidden"); // モーダルを閉じる
    }
  });
});
