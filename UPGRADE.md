# Upgrade from v1 to v2

## catalyst_builder

Update catalyst_builder to ^5.0.0

## Service registration

Update your code:
```diff
 void main() {
   // Create an instance of the service provider
-  var provider = DefaultServiceProvider();
-  provider
+  var container = ServiceContainer();
+  container
   // Extension method from the explorator package
     ..useExplorator(
-      routeBuilder: MaterialRouteBuilder(),
     )
+    ..setupExplorator(
+      routeBuilder: MaterialRouteBuilder(),
+    )
     ..boot();
   // Run the app
-  runApp(MyApp(provider));
+  runApp(MyApp(container));
 }
```
