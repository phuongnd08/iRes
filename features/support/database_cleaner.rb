DatabaseCleaner.clean_with :truncation

Before('~@javascript') do
  DatabaseCleaner.strategy = :transaction
end

Before('@javascript') do
  DatabaseCleaner.strategy = :truncation
end

After do
  DatabaseCleaner.clean
end
