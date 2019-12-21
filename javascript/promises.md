Motivation: no more nested callback calls ("callback pyramid of doom").

Given these functions:

	function successCallback(result) {
		console.log('success: ' + result);
	}

	function failureCallback(error) {
		console.error('error: ' + result);
	}

Old and busted:

	doSomethingAsync(params, successCallback, failureCallback);

New Hotness:

	const promise = doSomethingAsync(params);
	promise.then(successCallback, failureCallback);

Promise Guarantees:

- callbacks will only run in the next run of the event loop
- added `then()` callbacks will be called even _after_ success/failure of the
  async operation
- multiple callbacks added with `then()` are executed in sequence

`then()` returns a new Promise:

	const promise = doSomethingAsync(params);
	const otherPromise = promise.then(successCallback, failureCallback);

`otherPromise` representds the completion of `doSomethingAsync()` _and_
`successCallback()` or `failureCallback()`, respectively.

`catch(failureCallback)` is shorthand for `then(null, failureCallback)`.

`then()` can be used after `catch()` to start new operations after the error.

	new Promise((resolve, reject) => {
		console.log('initial');
		resolve();
	})
	.then(() => {
		// throw new Error('failed');
		console.log('do this'); // won't be displayed
	})
	.catch(() => {
		console.error('error handling');
	})
	.then(() => {
		// NOTE: also called if no catch was called!
		console.log('recovery, do something new');
	});

`Promise.resolve()` returns a promise object with the given value.
`Promise.reject()` returns a promise object rejected with a reason.

`Promise.all()` waits for the execution of multiple promises:

	Promise.all([f1(), f2(), f3()])
		.then(([res1, res2, res3]) => {
		// do something with results
	};

`Promise.race()` waits for one (the fastest) promise to fulfill.

The `async` keyword turns a function into a promise:

	async function hello(toWhom) {
		return `Hello, ${toWhom}!`;
	}

	hello('World').then(console.log);

The `await` keyword synchronously waits for the promise to be fulfilled. It can
only be used inside a function declared with `async`:

	async function hello(toWhom) {
		return `Hello, ${toWhom}!`;
	}

	async function whatever() {
		const message = await hello('World');
		console.log(message);
	}
	whatever();
