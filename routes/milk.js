const router = require('express').Router();

router.get('/', (req, res) => {
    res.send('Woah milky!');
});

module.exports = router;
