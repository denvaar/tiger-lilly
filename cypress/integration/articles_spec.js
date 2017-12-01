describe('Articles index', function() {
  it('Visits the index page', function() {
    cy.visit('localhost:4000');
    cy.get('.navbar').contains('About');
    cy.get('.navbar').contains('Articles');
    cy.get('.navbar').contains('Today I Learned');
  });

  it('Searches articles by title', function() {
    cy.visit('localhost:4000');
    cy.get('input[name="q"]').type('Tree');
    cy.get('form').submit();
    cy.get('h2').should('have.length', 4);
  });
});
