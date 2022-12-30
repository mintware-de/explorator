# explorator

Explorator is a routing system which works great together
with [catalyst_builder](https://pub.dev/packages/catalyst_builder) and the default Flutter router.

The main advantage is having dependency injection in all your routes / widgets without wire them the
hard way.

## Installation / Configuration
[Quick start guide](./doc/quick-start.md)

## FAQ

### Can I add more than one RouteProvider?

Yes, that's definitive one of the design principles of this package. I'm a fan of the OCP => you can
add more routes without touching existing code.

### Is Flutter web supported?
Yes, all platforms are supported. 

## Tests

```bash
./run_tests.sh
```
