describe('New Session', function() {
  it('User able to log in', function() {
    cy.visit('localhost:4000/sessions/new');
    cy.get('#user_email').type('denverpsmith@gmail.com');
    cy.get('#user_password').type('password{enter}');
    cy.contains('Sign in successful.');
  });
});
