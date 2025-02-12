//= require active_admin/base

document.addEventListener("DOMContentLoaded", function () {
  const initiatorSelect = document.querySelector("#exchange_initiator_id");
  const recipientSelect = document.querySelector("#exchange_recipient_id");

  const AddButtons = document.querySelectorAll('.has_many_add');

  if (AddButtons.length > 0) {
    AddButtons.forEach(button => {
      button.addEventListener("click", function () {

        const observer = new MutationObserver((mutations, observer) => {
          const initiatorTargetElement = document.querySelector("#initiator-target-select");
          const roleTargetElement = document.querySelector(".role-select");
          console.log(initiatorTargetElement);

          const recipientTargetElement = document.querySelector("#recipient-target-select");
          console.log(recipientTargetElement);

          console.log(initiatorSelect.value);
          console.log(recipientSelect.value);

          // call two ajax with the init and recip

          callAPIFor(initiatorSelect.value, initiatorTargetElement);
          callAPIFor(recipientSelect.value, recipientTargetElement);


          observer.disconnect();
        });

        observer.observe(document.body, { childList: true, subtree: true });
      });
    });

    if (initiatorSelect) {
      initiatorSelect.addEventListener("change", function () {
        console.log(initiatorSelect.value);
        const initiatorTargetElement = document.querySelector("#initiator-target-select");
        console.log(initiatorTargetElement);
        callAPIFor(initiatorSelect.value, initiatorTargetElement);
      }
    );
    }

    if (recipientSelect) {
      recipientSelect.addEventListener("change", function () {
        console.log(recipientSelect.value);
        const recipientTargetElement = document.querySelector("#recipient-target-select");
        console.log(recipientTargetElement);
        callAPIFor(recipientSelect.value, recipientTargetElement);
      });
    }
  }

  function callAPIFor(userId, targetElement) {
    fetch(`/exchanges/load_boxes?user_id=${userId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
    }
    })
    .then(response => response.json())
    .then(data => {
      targetElement.innerHTML = '';
      const promptOption = document.createElement('option');
      promptOption.textContent = 'Sélectionnez une boite';
      promptOption.disabled = true;
      promptOption.selected = true;
      targetElement.appendChild(promptOption);

      data.forEach(box => {
        const option = document.createElement('option');
        option.value = box.id;
        const VinyardName = box.vinyard ? box.vinyard.name : 'Inconnu';
        const DividendeYear = box.dividende ? box.dividende.year : 'Inconnu';
        option.textContent = `${VinyardName} - ${DividendeYear}`;
        targetElement.appendChild(option);
      });
    });
  }
  // from the two api response build two lists aznd render them in two selects
});