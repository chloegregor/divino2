//= require active_admin/base
//= require active_admin/base
document.addEventListener("DOMContentLoaded", function () {
  console.log("DOM entièrement chargé !");

  const initiatorSelect = document.querySelector("select[name='exchange[initiator_id]']");
  const recipientSelect = document.querySelector("select[name='exchange[recipient_id]']");
  const AddButtons = document.querySelectorAll('.has_many_add');

  if (AddButtons.length > 0) {
    AddButtons.forEach(button => {
      button.addEventListener("click", function () {
        console.log("Bouton 'Ajouter une boîte' cliqué !");

        const observer = new MutationObserver((mutations, observer) => {
          document.querySelectorAll(".box-exchange-select").forEach(select => {
            const fieldset = select.closest(".inputs.has_many_fields"); // Trouve le bon fieldset
            const roleSelect = fieldset ? fieldset.querySelector(".role-select") : null; // Cherche role-select dans ce fieldset

            if (roleSelect) {
              const role = roleSelect.value;
              const UserSelect = role === 'initiator' ? initiatorSelect : recipientSelect;

              if (UserSelect) {
                console.log(`DEBUG: fieldset trouvé ?`, fieldset);
                console.log(`DEBUG: Role Select trouvé ?`, roleSelect);
                console.log(`DEBUG: Valeur de role-select ?`, role);

                loadBoxes(UserSelect.value, select);
                console.log(`Boîtes chargées pour le rôle ${role}:`, UserSelect.value);

                // Éviter les doublons d'événements
                UserSelect.removeEventListener("change", updateBoxes);
                UserSelect.addEventListener("change", updateBoxes);

                function updateBoxes() {
                  console.log(`Changement détecté (${role}):`, UserSelect.value);
                  loadBoxes(UserSelect.value, select);
                }
              }
            } else {
              console.error("Impossible de trouver le champ role pour :", select);
            }
          });

          observer.disconnect(); // Arrêter l'observation après la mise à jour
        });

        observer.observe(document.body, { childList: true, subtree: true });
      });
    });
  } else {
    console.log("Le bouton 'Ajouter une boîte' n'a pas été trouvé !");
  }

  // 🔹 Fonction pour charger dynamiquement les boîtes
  function loadBoxes(userId, selectElement) {
    if (!userId) return;

    console.log('Envoi de la requête AJAX pour:', userId);
    fetch(`/exchanges/load_boxes?user_id=${userId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log("Boîtes reçues : ", data);
      console.log("Sélecteur à mettre à jour : ", selectElement);

      selectElement.innerHTML = '';
      const promptOption = document.createElement('option');
      promptOption.textContent = 'Sélectionnez une boite';
      promptOption.disabled = true;
      promptOption.selected = true;
      selectElement.appendChild(promptOption);

      data.forEach(box => {
        const option = document.createElement('option');
        option.value = box.id;
        const VinyardName = box.vinyard ? box.vinyard.name : 'Inconnu';
        const DividendeYear = box.dividende ? box.dividende.year : 'Inconnu';
        option.textContent = `${VinyardName} - ${DividendeYear}`;
        selectElement.appendChild(option);
      });
    });
  }

  // 🔹 Charger les boîtes au chargement si un initiator ou recipient est déjà sélectionné
  document.querySelectorAll(".box-exchange-select").forEach(select => {
    const fieldset = select.closest(".inputs.has_many_fields");
    const roleSelect = fieldset ? fieldset.querySelector(".role-select") : null;
    if (roleSelect) {
      const role = roleSelect.value;
      const UserSelect = role === 'initiator' ? initiatorSelect : recipientSelect;
      if (UserSelect && UserSelect.value) {
        loadBoxes(UserSelect.value, select);
      }
    }
  });

  // 🔹 Ajouter un événement pour écouter les changements sur l'initiator et le recipient
  function updateAllBoxes(userSelect, roleFilter) {
    document.querySelectorAll(".box-exchange-select").forEach(select => {
      const fieldset = select.closest(".inputs.has_many_fields");
      const roleSelect = fieldset ? fieldset.querySelector(".role-select") : null;
      if (roleSelect && roleSelect.value === roleFilter) {
        loadBoxes(userSelect.value, select);
      }
    });
  }

  if (initiatorSelect) {
    initiatorSelect.addEventListener("change", function () {
      updateAllBoxes(initiatorSelect, "initiator");
    });
  }

  if (recipientSelect) {
    recipientSelect.addEventListener("change", function () {
      updateAllBoxes(recipientSelect, "recipient");
    });
  }

});
