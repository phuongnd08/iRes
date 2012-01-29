Before(:all) do
  DatabaseCleaner.clean_with :truncation
end

Before('~@javascript') do
  DatabaseCleaner.strategy = :transaction
end

Before('@javascript') do
  DatabaseCleaner.strategy = :truncation
end

After do
  DatabaseCleaner.clean
end
