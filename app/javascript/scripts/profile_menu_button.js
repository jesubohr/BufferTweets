const menuButtons = document.querySelectorAll('.menu-button')

menuButtons.forEach((button) => {
  button.addEventListener('click', (ev) => {
    const menu = document.getElementById(`${button.dataset.target}`)

    if (menu.classList.contains('fadeIn')) {
      menu.classList.remove('fadeIn')
      menu.classList.add('fadeOut')
    } else {
      menu.classList.remove('fadeOut')
      menu.classList.add('fadeIn')
    }
  })
})
