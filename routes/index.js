const router = require('express').Router();

router.get('/', (req, res) => {
    res.render('index', {title: 'Index', message: 'This is the index page'})
});

module.exports = router;
