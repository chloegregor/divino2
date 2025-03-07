//= require active_admin/base

document.addEventListener("DOMContentLoaded", function () {
  const initiatorSelect = document.querySelector("#exchange_initiator_id");
  const recipientSelect = document.querySelector("#exchange_recipient_id");

  const initiatorContainer = document.querySelector("#initiator-boxes-container");
  const recipientContainer = document.querySelector("#recipient-boxes-container");



  if (initiatorContainer) {
    const addButton = initiatorContainer.querySelector(".has_many_add");
    if (addButton) {
      addButton.addEventListener("click", function () {
        const observer = new MutationObserver((mutations, observer) => {
          const initiatorTargetElements = document.querySelectorAll("#initiator-target-select");
          const lastInitiatorTargetElement = initiatorTargetElements[initiatorTargetElements.length - 1];

          observer.disconnect();
          callAPIFor(initiatorSelect.value, lastInitiatorTargetElement);
        });

        observer.observe(document.body, { childList: true, subtree: true });
      });
    }
  }

  if (recipientContainer) {
    const addButton = recipientContainer.querySelector(".has_many_add");
    if (addButton) {
      addButton.addEventListener("click", function () {
        const observer = new MutationObserver((mutations, observer) => {
          const recipientTargetElements = document.querySelectorAll("#recipient-target-select");
          const lastRecipientTargetElement = recipientTargetElements[recipientTargetElements.length - 1];

          observer.disconnect();
          callAPIFor(recipientSelect.value, lastRecipientTargetElement);
        });

        observer.observe(document.body, { childList: true, subtree: true });
      });
    }
  }

  if (initiatorSelect) {
    initiatorSelect.addEventListener("change", function () {
      console.log("Initiator changed:", initiatorSelect.value);
      const initiatorTargetElements = document.querySelectorAll("#initiator-target-select");

      // ✅ Met à jour **tous** les selects initiator-target
      initiatorTargetElements.forEach((element) => {
        callAPIFor(initiatorSelect.value, element);
      });
    });
  }

  if (recipientSelect) {
    recipientSelect.addEventListener("change", function () {
      console.log("Recipient changed:", recipientSelect.value);
      const recipientTargetElements = document.querySelectorAll("#recipient-target-select");
     recipientTargetElements.forEach((element) => {
        callAPIFor(recipientSelect.value, element);
      });
    });
  }
});

function callAPIFor(userId, targetElement) {
  if (!userId || !targetElement) return; // ✅ Évite les erreurs si `targetElement` est null

  fetch(`/exchanges/load_boxes?user_id=${userId}`, {
    method: "GET",
    headers: { "Content-Type": "application/json" },
  })
    .then((response) => response.json())
    .then((data) => {
      targetElement.innerHTML = ""; // ✅ Met à jour seulement l'élément passé

      const promptOption = document.createElement("option");
      promptOption.textContent = "Sélectionnez une boite";
      promptOption.disabled = true;
      promptOption.selected = true;
      targetElement.appendChild(promptOption);

      data.forEach((box) => {
        const option = document.createElement("option");
        option.value = box.id;
        const vinyardName = box.vinyard ? box.vinyard.name : "Inconnu";
        const dividendeYear = box.dividende ? box.dividende.year : "Inconnu";
        option.textContent = `${vinyardName} - ${dividendeYear}`;
        targetElement.appendChild(option);
      });
    })
    .catch((error) => console.error("Erreur lors du chargement des boîtes :", error));
}
