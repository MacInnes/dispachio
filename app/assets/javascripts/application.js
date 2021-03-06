// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require jquery-ui
//= require popper
//= require bootstrap

$(document).ready(function(){
  navSetup();
  $('#logout-btn').click(function(){
    localStorage.clear();
  })

  $('#registration-submit').click(function(){
    var username = $('#username').val();
    var email = $('#email').val();
    var password = $('#password').val();
    var role = $('input[name=role]:checked').val();
    fetch('/api/v1/users', {
      method: 'post',
      headers: { 'Content-Type': 'application/json'},
      body: JSON.stringify({
        username: username,
        email: email,
        password: password,
        role: role
      })
    })
      .then(response => response.json())
      .then(formatted_response => setStorage(formatted_response))
      .catch(error => console.error(error))
  })

  $('#login-submit').click(function(){
    var username = $('#username').val();
    var password = $('#password').val();
    fetch('/api/v1/login', {
      method: 'post',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        username: username,
        password: password
      })
    })
      .then(response => response.json())
      .then(formatted_response => setStorage(formatted_response))
      .catch(error => console.error(error))
  })

})

function navSetup(){
  if (localStorage.id){
    // display welcome username and logout button, hide register/login button
    $('.register').hide();
    $('#nav-username').text(`Welcome, ${localStorage.username}!`)
    $('#logout-btn').show();
  } else {
    // display registration / login links
    $('.register').show();
  }
}

function setStorage(user_data){
  localStorage.id = user_data.data.attributes.id
  localStorage.username = user_data.data.attributes.username
  localStorage.api_key = user_data.data.attributes.api_key
  localStorage.role = user_data.data.attributes.role
  redirect(localStorage.role, localStorage.id)
}

function redirect(role, id){
  window.location = `${role}/${id}`
}
