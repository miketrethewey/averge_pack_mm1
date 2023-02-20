python -m pip install -r "./resources/app/meta/manifests/pip_requirements.txt"
mkdir ./failures
echo "" > ./failures/errors.txt
python -m resources.tests.items
python -m resources.tests.functions
python -m resources.tests.locations
python -m resources.tests.asserts.validate

echo "ERRORS:"
cat ./failures/errors.txt
