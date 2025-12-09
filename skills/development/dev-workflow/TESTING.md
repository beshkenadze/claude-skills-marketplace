# Integration Testing Guide

Write tests for new functionality to ensure quality and prevent regressions.

## Test File Location

Place test files in the appropriate test directory:
- Swift/Xcode: `Tests/{ProjectName}Tests/`
- TypeScript: `tests/` or `__tests__/`
- Python: `tests/`

## Naming Convention

Name test files to match the feature:
- Feature: `AudioPipeline` → Test: `AudioPipelineTests.swift`
- Feature: `UserService` → Test: `UserService.test.ts`

## Test Structure

### Swift/XCTest
```swift
import XCTest
@testable import MyApp

final class FeatureTests: XCTestCase {

    func testBasicFunctionality() throws {
        // Arrange
        let sut = FeatureUnderTest()

        // Act
        let result = sut.doSomething()

        // Assert
        XCTAssertEqual(result, expectedValue)
    }

    func testAsyncOperation() async throws {
        let sut = AsyncFeature()
        let result = try await sut.asyncOperation()
        XCTAssertNotNil(result)
    }
}
```

### TypeScript/Jest
```typescript
import { FeatureUnderTest } from '../src/feature';

describe('FeatureUnderTest', () => {
    it('should perform basic operation', () => {
        const sut = new FeatureUnderTest();
        const result = sut.doSomething();
        expect(result).toBe(expectedValue);
    });

    it('should handle async operations', async () => {
        const result = await sut.asyncOperation();
        expect(result).toBeDefined();
    });
});
```

## What to Test

### Unit Tests
- Individual functions/methods
- Edge cases and error handling
- Input validation

### Integration Tests
- Component interactions
- Pipeline stages working together
- Service layer integration

### Required Coverage
1. **Happy path** - Normal successful operation
2. **Error cases** - Expected failures handled correctly
3. **Edge cases** - Boundary conditions
4. **Async behavior** - Concurrent operations

## Test Patterns for Pipelines

When testing pipeline components:

```swift
func testPipelineStagesProcessSequentially() async throws {
    let pipeline = Pipeline()

    // Add tracking stages
    let tracker = ExecutionTracker()
    pipeline.append(TestStage(id: "stage-1", tracker: tracker))
    pipeline.append(TestStage(id: "stage-2", tracker: tracker))

    // Process
    try await pipeline.process(testInput)

    // Verify order
    XCTAssertEqual(tracker.order, ["stage-1", "stage-2"])
}
```

## Mocking Dependencies

### Swift
```swift
class MockService: ServiceProtocol {
    var capturedInput: String?
    var mockResult: Result<Data, Error> = .success(Data())

    func process(_ input: String) async throws -> Data {
        capturedInput = input
        return try mockResult.get()
    }
}
```

### TypeScript
```typescript
const mockService = {
    process: jest.fn().mockResolvedValue(expectedData)
};
```

## Running Tests

### Swift/Xcode
```bash
xcodebuild test -scheme MyApp -configuration Debug \
    -destination 'platform=macOS' \
    OTHER_LDFLAGS="-Wl,-undefined,dynamic_lookup"
```

### TypeScript
```bash
npm test
# or
bun test
```

### Specific Test Suite
```bash
# Xcode
xcodebuild test -scheme MyApp \
    -only-testing:MyAppTests/FeatureTests

# Jest
npm test -- --testPathPattern=feature.test.ts
```

## Test Checklist

Before marking implementation complete:

- [ ] Unit tests for new functions
- [ ] Integration tests for component interactions
- [ ] Error case coverage
- [ ] Async operation tests (if applicable)
- [ ] All tests passing locally
- [ ] No test regressions (existing tests still pass)
