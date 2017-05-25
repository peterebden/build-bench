java_library(
    name = 'example',
    srcs = glob(['src/main/java/**/*.java']),
)

java_library(
    name = 'example-tests',
    srcs = glob(['src/test/java/**/*.java'], excludes = ['*Test.java']),
    test_only = True,
    deps = [
        ':example',
        ':hamcrest-core',
        ':junit',
    ],
)

# Break tests into multiple parts (rather than having one huge test target that tests everything)
for src in glob(['src/test/java/**/*Test.java'], excludes = ['src/test/java/**/*AbstractTest.java']):
    name, _ = splitext(src[len('src/test/java/org/apache/commons/math3/'):-5])
    java_test(
        name = name.replace('/', '_'),
        srcs = [src],
        resources = glob([
            'src/test/resources/**/*',
            'src/main/resources/**/*',
        ]),
        deps = [
            ':example',
            ':example-tests',
            ':hamcrest-core',
            ':junit',
        ],
    )

# define a dependency
maven_jar(
    name = 'junit',
    id = 'junit:junit:4.11',
)

maven_jar(
    name = 'hamcrest-core',
    id = 'org.hamcrest:hamcrest-core:1.3',
)
