// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function () {
  function handleAddBox(buttonClass, containerClass, selectClass, role) {
      const addButton = document.querySelector(`.${buttonClass}`);
      const container = document.querySelector(`.${containerClass}`);
      if (!addButton || !container) return;

      addButton.addEventListener("click", function () {
          const firstSelect = container.querySelector(`.${selectClass}`);
          if (!firstSelect) return;

          const newDiv = document.createElement("div");
          newDiv.classList.add(containerClass, "new");

          // Cloner et réinitialiser le select
          const newSelect = firstSelect.cloneNode(true);
          newSelect.value = "";

          // Mettre à jour l'index du select
          updateSelectIndex(newSelect, containerClass);

          // Création du bouton de suppression
          const removeBtn = document.createElement("button");
          removeBtn.textContent = "X";
          removeBtn.classList.add("btn-remove");

          newDiv.appendChild(newSelect);
          newDiv.appendChild(removeBtn);
          container.appendChild(newDiv);

          updateOptions(containerClass, selectClass);
      });
  }

  function updateSelectIndex(select, containerClass) {
      const existingFields = document.querySelectorAll(`.${containerClass} select`);
      const newIndex = existingFields.length; // Assigne un index unique
      const nameAttr = select.getAttribute("name");

      if (nameAttr) {
          const updatedName = nameAttr.replace(/\[\d+\]/, `[${newIndex}]`); // Remplace l'ancien index
          select.setAttribute("name", updatedName);
      }
  }

  function updateOptions(containerClass, selectClass) {
      const selects = document.querySelectorAll(`.${containerClass} .${selectClass}`);
      const selectedValues = [...selects].map(select => select.value).filter(val => val);

      selects.forEach(select => {
          [...select.options].forEach(option => {
              if (selectedValues.includes(option.value) && option.value !== select.value) {
                  option.hidden = true;
              } else {
                  option.hidden = false;
              }
          });
      });
  }

  function handleSelectChange(selectClass, buttonClass, containerClass) {
      document.addEventListener("change", function (event) {
          if (event.target.matches(`.${selectClass}`)) {
              const selectedValues = [...document.querySelectorAll(`.${containerClass} .${selectClass}`)]
                  .map(select => select.value)
                  .filter(val => val);
              updateOptions(containerClass, selectClass);

              const addButton = document.querySelector(`.${buttonClass}`);
              if (addButton) addButton.classList.toggle("hidden", selectedValues.length === 0);
          }
      });
  }

  function handleRemoveBox(containerClass, selectClass) {
      document.addEventListener("click", function (event) {
          if (event.target.matches(".btn-remove")) {
              event.target.parentElement.remove();
              updateOptions(containerClass, selectClass);

              // Mettre à jour les index après suppression
              document.querySelectorAll(`.${containerClass} .${selectClass}`).forEach(updateSelectIndex);
          }
      });
  }

  // Gestion des initiators
  handleAddBox("btn-add-initiator-boxes", "select-hidden-initiator", "select-initiator", "initiator");
  handleSelectChange("select-initiator", "btn-add-initiator-boxes", "select-hidden-initiator");
  handleRemoveBox("select-hidden-initiator", "select-initiator");

  // Gestion des recipients
  handleAddBox("btn-add-recipient-boxes", "select-hidden-recipient", "select-recipient", "recipient");
  handleSelectChange("select-recipient", "btn-add-recipient-boxes", "select-hidden-recipient");
  handleRemoveBox("select-hidden-recipient", "select-recipient");
});
