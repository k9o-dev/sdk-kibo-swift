Pod::Spec.new do |s|
  s.name             = 'K9OKibo'
  s.version          = '1.4.0'
  s.summary          = 'Kilimanjaro Kibo Zero-Knowledge BYOK/HYOK vault SDK for iOS and macOS.'
  s.description      = <<-DESC
    K9OKibo is the iOS/macOS Swift SDK for Kibo, the Kilimanjaro
    Zero-Knowledge BYOK/HYOK vault. encrypt/decrypt run entirely
    client-side against the customer's own KMS; the platform never sees
    plaintext or unwrapped keys. The crypto lives in the audited Rust core
    (kibo-kms-rest-ffi) compiled to a native library and bound via uniffi.
  DESC
  s.homepage         = 'https://kilimanjaro.dev'
  s.documentation_url = 'https://docs.kilimanjaro.dev'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'Kilimanjaro' => 'engineering@kilimanjaro.dev' }
  s.source           = { :git => 'https://github.com/k9o-dev/sdk-kibo-swift.git', :tag => s.version.to_s }
  s.ios.deployment_target  = '15.0'
  s.osx.deployment_target  = '12.0'
  s.swift_version    = '5.9'
  s.source_files     = 'Sources/K9OKibo/**/*.swift'
  # The compiled core is vendored as an xcframework (CI-built per provider).
  s.vendored_frameworks = 'Frameworks/kibo_kms_rest_ffiFFI.xcframework'
  s.frameworks       = 'Foundation'
end
