var checkboxes = document.querySelectorAll('input[type="checkbox"]');

// Itera sobre os checkboxes e os marca como selecionados
checkboxes.forEach(function(checkbox) {
    checkbox.checked = true;
});
