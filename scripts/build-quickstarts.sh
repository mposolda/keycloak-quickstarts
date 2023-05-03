#!/bin/bash -e

if [ -n "$PRODUCT" ] && [ "$PRODUCT" == "true" ]; then
  args="-s $PRODUCT_MVN_SETTINGS  -Dmaven.repo.local=$PRODUCT_MVN_REPO"
else
  args="-s maven-settings.xml"
fi

# generate keycloak.json
for f in $(find . -type f -name 'keycloak-example.json'); do
   cp "$f" "${f%-example.json}.json"
done

for f in $(find . -type f -name 'keycloak-saml-example.xml'); do
   cp "$f" "${f%-example.xml}.xml"
done

if [ "$1" = "jakarta" ]; then
  echo "Using jakarta profile when building maven artifacts"
  args="$args -Djakarta"
fi

# TODO:mposolda
echo "Maven version obtain"
mvn --version

mvn clean install $args -DskipTests -B -Dnightly
if [ -n "$PRODUCT" ] && [ "$PRODUCT" == "true" ]; then
  dist=$PRODUCT_DIST
else
  dist="keycloak-dist"
fi

if [ "$1" != "jakarta" ]; then
  cp authz-js-policies/target/authz-js-policies.jar $dist/providers
else
  cp user-storage-simple/target/user-storage-properties-example.jar $dist/providers
  cp user-storage-jpa/conf/quarkus.properties $dist/conf
  cp user-storage-jpa/target/user-storage-jpa-example.jar $dist/providers
fi

