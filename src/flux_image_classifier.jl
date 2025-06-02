# Import necessary libraries
using Flux
using Images
using ImageMagick
using FileIO

# Load and preprocess data
function load_data(path)
    images = []
    for file in readdir(path)
        img = load(joinpath(path, file))
        push!(images, img)
    end
    return images
end 

train_images = load_data("../data/neptune_storm_nostorm/train")
test_images = load_data("../data/neptune_storm_nostorm/test")

# Define the model
model = Chain(
    Conv((3, 3), 1=>16, relu),
    MaxPool((2, 2)),
    Conv((3, 3), 16=>32, relu),
    MaxPool((2, 2)),
    flatten,
    Dense(32*6*6, 10), relu,
    Dense(10, 2), softmax
)

# Define a loss function
loss(x, y) = Flux.Losses.logitcrossentropy(model(x), y)

# Choose an optimizer
opt = Flux.Optimise.ADAM(0.001)

# Train the model
function train_model()
    for epoch in 1:10
        for (x, y) in zip(train_images, train_labels)
            gs = gradient(() -> loss(x, y), Flux.params(model))
            Flux.Optimise.update!(opt, Flux.params(model), gs)
        end
        println("Epoch $epoch complete")
    end
end

# Evaluate the model
function evaluate_model()
    correct = 0
    for (x, y) in zip(test_images, test_labels)
        pred = argmax(model(x))
        if pred == y
            correct += 1
        end
    end
    accuracy = correct / length(test_labels)
    println("Model accuracy: $accuracy")
end

# Run training and evaluation
train_model()
evaluate_model() 