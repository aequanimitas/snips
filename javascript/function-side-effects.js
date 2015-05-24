var assert = require('assert');
describe('Imagine your app includes a shopping cart, and they can save cart contents between sessions.', function() {
  it('Our Goal is to change the order of the user for the CURRENT SESSION ONLY.', function () {
    var cartProto = {
        items: [],
  
        addItem: function(item) {
          this.items.push(item);
        }
      }
  
      createCart = function(items) {
        var cart = Object.create(cartProto);
        // cart.items = Object.create(items);
        cart.items = items; 
        return cart;
      },
  
      savedCart = createCart(["apple", "pear", "lanzones"]);
  
      session = {
        get: function get(){
          return this.cart;
        },
  
        cart: createCart(savedCart.items)
      };
  
      session.cart.addItem('aratiles');
      console.log('Saved Cart items: ' + savedCart.items);
      console.log('Session Cart items: ' + session.cart.items);
  
      console.log(savedCart.items.indexOf('aratiles'));
      console.log(session.cart.items.indexOf('aratiles'));

      assert.notEqual(session.cart.items.indexOf('aratiles'), -1, 
                   'Passes: Session card has aratiles');
  
      assert.equal(savedCart.items.indexOf('aratiles'), -1, 
                   'Fails: Stored cart has aratiles');

      assert.equal(0, 1, "Continue with more tests");
  });
});
